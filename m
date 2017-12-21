From: david@lechnology.com (David Lechner)
Date: Thu, 21 Dec 2017 10:52:58 -0600
Subject: [PATCH v3 4/5] ARM: davinci: convert to common clock framework
In-Reply-To: <d8833055-51ad-a71f-f326-22719cfc1770@ti.com>
References: <1512785711-15064-1-git-send-email-david@lechnology.com>
 <1512785711-15064-5-git-send-email-david@lechnology.com>
 <b8025b62-c7c0-29f8-388d-d84816adf688@ti.com>
 <4d7e4751-490b-5dfc-ef75-195fe41719b7@lechnology.com>
 <d8833055-51ad-a71f-f326-22719cfc1770@ti.com>
Message-ID: <d196d078-8cd1-01c4-d780-74c7e4a54b8f@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/2017 06:34 AM, Sekhar Nori wrote:
> 
> All I can say is that issue has been noted within TI and I believe
> (hope) that help is on the way!
> 
> If we do go the completely separate clock driver route, I think even
> migrating outside of mach-davinci should not be that tough.
> 

Based on your responses, I think we have a pretty clear path forward 
now. I'm sold on the all at once approach.

If you can pick up the first 3 patches from this series, I have one or 
two more I can send that depend on those changes that are not 
intermediate steps.

If TI is able to spend some time on this, it would be nice if they could 
look at fixing up the reset framework since that is something I haven't 
attempted yet.

And I can work on fixing up the PLL and PSC drivers I already have in 
drivers/clk/davinci.
