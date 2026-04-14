# Sydney Housing Market Analysis

## Business Question - Can the average person in Sydney actually afford to buy a property and if so, what type of property and where? 

Context behind Business Question - I was having a conversation with my friends on whether Property price in Sydney are out of control and if we would ever own a home in the future. However, mid conversartion I thought to myself why not find out the answer for ourselves?

Sydney is infamous for being consistently ranked among the world's least affordable cities. But deciding which metric we shall use to measure how "unaffordable" changes the answer entirely. I wanted to go beyond the headlines and understand what's actually driving the market prices, is it location, suburb reputation, property type or income levels etc. 

This project was built to answer one question: If you were a first-home buyer or property investor in Sydney, are there any property which you can afford to buy?

### What I Did
To answer this, I sourced real property transaction data and did the following:
- Data cleaning in MySQL - Removed incomplete records, standardised suburb and property type fields across the full dataset
- Feature engineering — Built derived metrics including price per square metre, price per bedroom, CBD distance bands (0–10km through to 50km+), suburb density, and inflation-adjusted prices
- True median computation — Used SQL window functions (ROW_NUMBER() OVER PARTITION) throughout rather than averages, which are distorted by a small number of ultra-premium sales
- Power BI dashboard — Built a 2-page interactive dashboard to explore findings across location, property type, value for money, density and price trends over time

### What I Found
### Property Prices based on Location
Location is one of the biggest factor in property price. Distance from the CBD is the single strongest price driver in the dataset. The further out you go, the more accessible prices become.

| Distance from CBD | Median Price |
|---|---|
| 0 – 10 km | $ 2.02M |
| 10 – 20 km | $ 1.79M |
| 20 – 30 km | $ 1.1M |
| 30 – 40 km | $ 1 M |
| 40 – 50 km | $ 1 M |
| 50+ km | $ 1 M |

The sharpest drop happens between 10–20km and 20–30km showing roughly a $700K difference. Beyond 30km, the prices don't change much. For a buyer with a limited budget, the 20–30km distance property offers the best trade-off between price and proximity.

### What property type should we consider buying?
A common assumption that people say is that units and apartments are the more affordable entry point into the market. However, the data says the opposite:

| Property Type | Median Price |
|---|---|
| Block of Units | $ 2.9M |
| Other types (Development etc) | $ 2 M |
| House | $ 1.4M |

Based on the table we can see that Houses are still the cheapest property type in the market. Whereas Units, particularly blocks of units in the inner side of Sydney, are the most expensive. Logically, it comes down to geography. Some of the most expensive suburbs in Sydney namely Barangaroo, Darling Point etc are dominated by apartment and unit stock, which pulls the unit median up. Houses, by volume, are concentrated in outer suburbs where prices are lower.

What this means for a buyer: If affordability is the priority, a house in the outer suburbs is a more accessible option than a unit in the inner city.

### Where should one look to find property which can be considered reasonable value for money?
Price per square metre tells you how much space you actually get for your money:

| Suburb | Price per sqm |
|---|---|
| Barangaroo | ~$23K |
| Surry Hills | ~$21K |
| Woollahra | ~$21K |

- **Barangaroo leads at $23K/sqm**, followed by Surry Hills and Woollahra at ~$21K/sqm
- Interestingly, the harbour suburbs such as Kurraba Point and Darling Point do not top this list despite having the some of the highest median income in the city. 
This is because the suburbs like Barangaroo are dominated by compact, high-end apartments. Harbour suburbs tend to have larger properties, which reduces the per-sqm cost as compared to houses.

What this means for a buyer: If you want more value for your money, the outer suburbs are where price per sqm drops significantly. Buying property in Suburbs near Inner Sydney is paying a premium for location, not for the quality or size of such properties.


### Does a higher density suburb mean a more expensive one?
In simple words, not necessarily and this matters if you want to stay close to the city without paying a premium price. Chippendale is one of the densest suburb in the dataset at **18,571 people per km²** and yet it does not appear in any top-price ranking by median price, price per sqm or price per bedroom.
The pattern holds more broadly since high density in Sydney tends to mean more housing supply, which keeps prices more accessible than the surrounding area.
For a buyer this means to remember not to automatically rule out a busy, dense suburb. It could be your best shot at staying inner-city without paying inner-city prices.

### Are property prices rising according to inflation or just rising consistently?
Nominal prices tell you what a property are sold for. Inflation-adjusted prices tell you whether prices are genuinely increasing in purchasing power parity (PPP) or simply moving with broader inflation.
The inflation-adjusted price trend in this dataset shows that Sydney property prices have risen beyond general inflation over the period analysed. For a buyer, this matters because it confirms that waiting for the right time to buy will not help. The real cost of buying in Sydney has increased over time, not just the number on the price tag.

### Can the average person afford to buy a house in Sydney?
Yes but where and what you can buy matters enormously.
The data points to one clear direction which is as you go further out from CBD you go the more affordable a house is. The 20–30km band is where prices drop sharply and then stagnates, meaning you're not saving much by going further beyond 30K from CBD. 
If staying closer to the city is important, density is your friend. Suburbs like Chippendale offer easier CBD access without the price tag that come along with it.
And if space is a priority, the further from the CBD you go, the more floor space your money buys. Inner-city suburbs charge a premium for its location.
The honest answer is that Sydney is expensive no matter where you go or look. But the data shows there are smarter ways to buy and a lot of the received wisdom regarding how to buy or what's "affordable" etc doesn't hold up when you actually look at the numbers.
