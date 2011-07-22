From: khilman@ti.com (Kevin Hilman)
Date: Fri, 22 Jul 2011 13:19:21 -0700
Subject: [RFC/PATCH 3/7] OMAP: McBSP: use existing macros for converting
	between devices
In-Reply-To: <4E296DFB.3010205@ru.mvista.com> (Sergei Shtylyov's message of
	"Fri, 22 Jul 2011 16:32:59 +0400")
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-5-git-send-email-khilman@ti.com>
	<4E296DFB.3010205@ru.mvista.com>
Message-ID: <87y5zqysom.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Sergei Shtylyov <sshtylyov@mvista.com> writes:

> On 22-07-2011 3:52, Kevin Hilman wrote:
>
>> For converting from struct device to platform_device, and from
>> platform_device to struct device,
>
>    You mean from platform_device to omap_device?
>

Yes indeed, thanks.  Updated patch below (only changelog changed)

Kevin
