From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Tue, 22 Nov 2011 09:45:03 +0100
Subject: [PATCH v2 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <20111122064727.GB15889@mwesterb-mobl.ger.corp.intel.com>
References: <cover.1306662317.git.mika.westerberg@iki.fi>
 <3ea8d56034f25cbe3fd8a4c31d7d0d1540b6ac7e.1306662317.git.mika.westerberg@iki.fi>
 <4EC27EED.4030108@metasoft.pl>
 <20111116065512.GB2703@mwesterb-mobl.ger.corp.intel.com>
 <4EC374F0.8000400@metasoft.pl>
 <20111119123837.GA2711@mwesterb-mobl.ger.corp.intel.com>
 <4ECA0147.4020806@metasoft.pl>
 <20111121080158.GA2713@mwesterb-mobl.ger.corp.intel.com>
 <4ECA11C5.802@metasoft.pl>
 <20111122064727.GB15889@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <4ECB610F.7020904@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-11-22 07:47, Mika Westerberg wrote:
> Let me know if this works for you. Basically it's the patch from you except
> that we use a flag to indicate if the channel is running or not.
> 

It works correctly. All of my simple hdd tests completed without any problems.
Thanks.
