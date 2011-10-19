From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 19 Oct 2011 15:56:34 +0200
Subject: [PATCH 3/4] ARM: OMAP3: cm-t35: fix audio
In-Reply-To: <4E9EAE69.6010305@ru.mvista.com>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
	<1319017160-20391-4-git-send-email-grinberg@compulab.co.il>
	<4E9EAE69.6010305@ru.mvista.com>
Message-ID: <4E9ED712.8090408@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On 10/19/11 13:03, Sergei Shtylyov wrote:
> Hello.
> 
> On 19-10-2011 13:39, Igor Grinberg wrote:
> 
>> TWL4030 audio codec is not being registered if no platform data is
>> supplied. Plovide platform data for the TWL4030 audio codec.
> 
>    s/Plovide/Provide/. Perhaps a committer can fix this typo.

This one is really nice ;)
Thanks

-- 
Regards,
Igor.
