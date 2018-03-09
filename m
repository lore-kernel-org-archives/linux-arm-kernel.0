From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 9 Mar 2018 20:26:03 +0300
Subject: [PATCH 3/3] arm64: dts: renesas: condor: add EtherAVB pins
In-Reply-To: <CAMuHMdVJkRuEvzmAJf2pWd9E+XVgmO122-2mHSgw7Y4aLXdfYA@mail.gmail.com>
References: <88e52531-e538-8685-110a-1a2e79a3fe49@cogentembedded.com>
 <82c33f37-bfbb-e515-f996-83333cd26171@cogentembedded.com>
 <CAMuHMdVJkRuEvzmAJf2pWd9E+XVgmO122-2mHSgw7Y4aLXdfYA@mail.gmail.com>
Message-ID: <b1450eb7-4635-804a-ed8b-34d6c1942fa4@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 03/09/2018 03:44 PM, Geert Uytterhoeven wrote:

>> Add the (previously omitted) EtherAVB pin data to the Condor board's
>> device tree.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> According to the Condor schematics, the KSZ9031RNXVB is wired to
> GEther by default. So I guess you are using a modified board?

  Artemy told me they haven't been able to bring up the GEther (due to wrong
base address?), so they resoldered the reisitors. He also told me there are now
versions of the board that wire the PHY to EtherAVB. Go figure...

[...]

MBR, Sergei
