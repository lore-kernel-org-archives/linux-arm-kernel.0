From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 19 Apr 2012 22:22:26 +0530
Subject: [PATCH] arm: davinci: pdctl next bit position incorrect
In-Reply-To: <4F8FECD6.6050105@mvista.com>
References: <1334745664-19275-1-git-send-email-m-karicheri2@ti.com>
 <4F8F22D1.8080309@ti.com> <4F8FECD6.6050105@mvista.com>
Message-ID: <4F9042CA.7050305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On 4/19/2012 4:15 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 19-04-2012 0:23, Sekhar Nori wrote:
> 
>>> The PDCTL NEXT bit is incorrectly set to bit 1 instead of bit 0. This
>>> patch fixes this issue
> 
>>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
> 
>> Applying this for v3.5.
> 
>    But why not to 3.4? It concerns turning on DSP domain on DM644x.

Yes, but I think as you noted sometime before, no one is really
depending on kernel to turn on DSP domain on DM644x. Its probably being
done from U-Boot or ROM code. This is not a v3.4 regression either.

Thanks,
Sekhar
