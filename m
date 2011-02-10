From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Thu, 10 Feb 2011 16:40:25 +0200
Subject: [PATCH 2/2] omap: rx51: mark reserved memory earlier
In-Reply-To: <1289568492.3297.277.camel@tubuntu>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
	<1287146784-5517-2-git-send-email-felipe.contreras@gmail.com>
	<1289568492.3297.277.camel@tubuntu>
Message-ID: <AANLkTikPp6hin3FAYNJG33_ac295UpJZy+146Et+b=fJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 3:28 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Fri, 2010-10-15 at 14:46 +0200, ext Felipe Contreras wrote:
>> So that omap_vram_set_sdram_vram() is called before
>> omap_vram_reserve_sdram_memblock().
>
> Is this still valid after the latest memblock stuff? I presume it is.
> I'm not able to test this, and you said you didn't test it, so I'm a bit
> uneasy about applying =).

This has been tested on other boards. Can you apply?

-- 
Felipe Contreras
