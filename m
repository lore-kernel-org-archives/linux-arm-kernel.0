From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 09:45:40 -0800
Subject: [PATCH v2 8/8] ARM: dts: kirkwood-rd88f6281: Utilize new DSA
 binding
In-Reply-To: <20170117173404.GG9470@lunn.ch>
References: <20170105192957.14304-1-f.fainelli@gmail.com>
 <20170105192957.14304-9-f.fainelli@gmail.com> <20170117173404.GG9470@lunn.ch>
Message-ID: <3255f84c-7d1c-0854-2373-08276ac6b271@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 09:34 AM, Andrew Lunn wrote:
> On Thu, Jan 05, 2017 at 11:29:57AM -0800, Florian Fainelli wrote:
>> Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net: dsa:
>> Document new binding"). The legacy binding node is kept included, but is marked
>> disabled.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts | 11 ++++++++
>>  arch/arm/boot/dts/kirkwood-rd88f6281.dtsi   | 44 +++++++++++++++++++++++++++++
>>  2 files changed, 55 insertions(+)
> 
> Hi Florian
> 
> What about arch/arm/boot/dts/kirkwood-rd88f6281-a.dts

Whoops, missed that one, let me resubmit a change to that file too along
with your tags on the other patches, thanks for testing and reviewing!
-- 
Florian
