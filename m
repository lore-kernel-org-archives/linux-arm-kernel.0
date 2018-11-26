From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 26 Nov 2018 16:55:31 +0530
Subject: [RFC 0/9] ASoC/ARM: Merge the davinci and omap audio directories
In-Reply-To: <20181108151628.GH56134@atomide.com>
References: <20181108083754.1746-1-peter.ujfalusi@ti.com>
 <20181108151628.GH56134@atomide.com>
Message-ID: <808d350d-9e0e-d9b5-a474-1a4fd0c9b292@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/18 8:46 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [181108 08:36]:
>> I believe with v1 all of this can be merged via ASoC tree as the chances of
>> conflicts are low for the touched arch/arm files. But Sekhar and Tony can
>> correct me if I'm wrong.
> 
> Good to see this :) Yes merging these changes via the ASoC tree makes
> sense to me. I will take a look and ack when you post the version
> without RFC.

Looks good to me too. And fine with the series getting merged through ASoC.

But will appreciate an immutable commit over v4.20-rc1 in case I do end
up queuing something that clashes with changes here (especially worried
about the defconfig changes - those are notorious for merge conflicts,
and are pain to resolve).

I will test this once the non-RFC version is posted.

Thanks,
Sekhar
