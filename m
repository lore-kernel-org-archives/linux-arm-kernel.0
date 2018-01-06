From: stefan@agner.ch (Stefan Agner)
Date: Sat, 06 Jan 2018 11:47:08 +0100
Subject: [PATCH 2/7] ARM: dts: imx6ul: update i.MX 6UltraLite iomux headers
In-Reply-To: <20180105164505.uzv7nu3r6awuyxzu@rob-hp-laptop>
References: <20180102164223.15230-1-stefan@agner.ch>
 <20180102164223.15230-2-stefan@agner.ch>
 <20180105164505.uzv7nu3r6awuyxzu@rob-hp-laptop>
Message-ID: <1cce13f19ae1f4242437292a2960d38e@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-05 17:45, Rob Herring wrote:
> On Tue, Jan 02, 2018 at 05:42:18PM +0100, Stefan Agner wrote:
>> From: Fugang Duan <fugang.duan@nxp.com>
>>
>> Update i.MX 6UltraLite IOMUXC pin defines.
> 
> That's obvious reading the diff. The commit message should tell me why. 
> They were wrong?

I guess pretty much :-)

What I can tell from the change itself it seems that daisy chain
configurations were missing. And some additional pinmux options. Will
update the commit message accordingly.

--
Stefan

> 
>>
>> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
