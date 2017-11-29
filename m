From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 29 Nov 2017 20:00:52 +0300
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77970: use CPG core clock
 macros
In-Reply-To: <20171129095558.wvvcvfctwfmtrkq4@verge.net.au>
References: <20171128202105.552196002@cogentembedded.com>
 <20171129095558.wvvcvfctwfmtrkq4@verge.net.au>
Message-ID: <d904863e-e8c9-76ad-9d12-fd36ed68c3b4@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2017 12:55 PM, Simon Horman wrote:

>> Now that the commit ecadea00f588 ("dt-bindings: clock: Add R8A77970 CPG
>> core clock definitions") has hit Linus' tree, we  can replace the bare
>> numbers (we had to use to avoid a cross tree dependency) with these macro
>> definitions...
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Thanks, applied.

    Not seeing these 2 patches in the today's devel branch tho...

MBR, Sergei
