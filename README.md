# Sydney Housing Market Analysis

## Business Question - Can the average person in Sydney actually afford to buy a property and if so, what type of property and in which suburbs? 

Context behind Business Question - I was having a conversation with my friends on whether Property price in Sydney are out of control and if we would ever own a home in the future. However, mid conversartion I thought to myself why not find out the answer for ourselves?

Sydney is infamous for being consistently ranked among the world's least affordable cities. But deciding which metric we shall use to measure how "unaffordable" changes the answer entirely. I wanted to go beyond the headlines and understand what's actually driving the market prices, is it location, suburb reputation, property type or income levels etc. 

**This project was built to answer one question: If you were a first-home buyer or property investor in Sydney, are there any property which you can afford to buy?
**

## Property Prices based on Location
Location is one of the biggest factor in property price. Distance from the CBD is the single strongest price driver in the dataset. The further out you go, the more accessible prices become.

| Distance from CBD | Median Price |
|---|---|
| 0 – 10 km | $ 2.02M |
| 10 – 20 km | $ 1.79M |
| 20 – 30 km | $ 1.1M |
| 30 – 40 km | $ 1 0M |
| 40 – 50 km | $ 1 M |
| 50+ km | $ 1 M |

The sharpest drop happens between 10–20km and 20–30km showing roughly a $700K difference. Beyond 30km, the prices don't change much. For a buyer with a limited budget, the 20–30km distance property offers the best trade-off between price and proximity.

## What property type should we consider buying?
A common assumption that people say is that units and apartments are the more affordable entry point into the market. However, the data says the opposite:

| Property Type | Median Price |
|---|---|
| Block of Units | $ 2.9M |
| Other types (Development etc) | $ 2 M |
| House | $ 1.4M |

Based on the table we can see that Houses are still the cheapest property type in the market. Whereas Units, particularly blocks of units in the inner side of Sydney, are the most expensive. Logically, it comes down to geography. Some of the most expensive suburbs in Sydney namely Barangaroo, Darling Point etc are dominated by apartment and unit stock, which pulls the unit median up. Houses, by volume, are concentrated in outer suburbs where prices are lower.

What this means for a buyer: If affordability is the priority, a house in the outer suburbs is a more accessible option than a unit in the inner city.

## Where should one look to find property which can be considered reasonable value for money?
Price per square metre tells you how much space you actually get for your money:
- **Barangaroo leads at $23K/sqm**, followed by Surry Hills and Woollahra at ~$21K/sqm
- Interestingly, the harbour suburbs such as Kurraba Point and Darling Point do not top this list despite having the some of the highest median income in the city. 
This is because the suburbs like Barangaroo are dominated by compact, high-end apartments. Harbour suburbs tend to have larger properties, which reduces the per-sqm cost as compared to houses.

What this means for a buyer: If you want more value for your money, the outer suburbs are where price per sqm drops significantly. Buying property in Suburbs near Inner Sydney is paying a premium for location, not for the quality or size of such properties.


### Does a busier suburb mean a more expensive one?
In simple words, not necessarily and this matters if you want to stay close to the city without paying a premium price. Chippendale is one of the densest suburb in the dataset at **18,571 people per km²** and yet it does not appear in any top-price ranking by median price, price per sqm or price per bedroom.
The pattern holds more broadly since high density in Sydney tends to mean more housing supply, which keeps prices more accessible than the surrounding area.
For a buyer this means to remember a automatically rule out a busy, dense suburb. It could be your best shot at staying inner-city without paying inner-city prices.

### Are property prices rising according to inflation or just rising consistently?
Nominal prices tell you what a property are sold for. Inflation-adjusted prices tell you whether prices are genuinely increasing in purchasing power parity (PPP) or simply moving with broader inflation.
The inflation-adjusted price trend in this dataset shows that real price growth exists, meaning Sydney property prices have risen beyond general inflation over the period analysed. For a buyer, this matters because it confirms that waiting does not generally help. The real cost of buying in Sydney has increased over time, not just the number on the price tag.

## In conclusion What Should a Buyer Actually Do?
Based on the data:
- If you want to buy a house: Look at the 20–30km band from the CBD. The Houses are the most affordable property type and the outer ring is where prices plateau. You get the most property for your money here.
- If you want a unit: Be aware that inner-city units command a significant premium. A unit in the outer suburbs will be considerably more affordable than the dataset's unit median suggests.
- **If space matters:** Avoid Barangaroo and the inner-city suburbs on price per sqm grounds. The further out you go, the more you get for each dollar spent on floor space.

