From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 10 Jun 2016 10:38:28 +0200
Subject: [PATCH/RFC v3 02/22] soc: renesas: Add R-Car RST driver
In-Reply-To: <CAMuHMdUX=iAe=51+8JyaKxMBOUA_jJXGK0BTKxRuTXtug_R1Tw@mail.gmail.com>
References: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
 <1464808880-343-3-git-send-email-geert+renesas@glider.be>
 <d38d97fb-5b96-0773-abf6-c737b4f2fef1@de.bosch.com>
 <CAMuHMdUX=iAe=51+8JyaKxMBOUA_jJXGK0BTKxRuTXtug_R1Tw@mail.gmail.com>
Message-ID: <fd389ff9-7863-b848-0e14-ca7241f44f6e@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.06.2016 09:58, Geert Uytterhoeven wrote:
> Hi Dirk,
>
> On Thu, Jun 2, 2016 at 7:42 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>>> +int __init rcar_rst_read_mode_pins(u32 *mode)
>>
>> Just a style issue: Is the string 'pins' in the function name still
>> relevant? I.e. what's about just 'rcar_rst_read_mode()'?
>
> I feel "mode" is a too generic word for a public API.
> It's used a several contexts inside the RST module (secure mode, 64-bit
> addressing mode, free-running mode, step-up mode).

What's about

rcar_rst_read_mode_monitor()

then?

Taken from the manual ;)


Best regards

Dirk
