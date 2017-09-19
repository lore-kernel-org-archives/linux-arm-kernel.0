From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 20 Sep 2017 00:51:05 +0530
Subject: [PATCH v4 4/6] ARM: dts: imx6dl-icore: Add LVDS support
In-Reply-To: <CAOMZO5C+DXAQu=2OUAquB2AKn8dOzadoPsdGD05hXAUBdTnYjQ@mail.gmail.com>
References: <1505121145-9507-1-git-send-email-jteki@openedev.com>
 <1505121145-9507-4-git-send-email-jteki@openedev.com>
 <CAOMZO5B0RAjdupLSe=S+tDEA-hpf-Si_4qjkcKC_ECX86PLScQ@mail.gmail.com>
 <CAMty3ZD3od1LXKai=kwq8hxGsa3EWcjQx5gyBtZvCM5ccC34ZQ@mail.gmail.com>
 <CAOMZO5C+DXAQu=2OUAquB2AKn8dOzadoPsdGD05hXAUBdTnYjQ@mail.gmail.com>
Message-ID: <CAMty3ZCQP5vnrU5MSzRFwRS+vS9a_ULt3sNB07BOHv0dCton0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Tue, Sep 19, 2017 at 9:22 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Jagan,
>
> On Tue, Sep 19, 2017 at 2:06 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>> Hi Fabio,
>>
>>> Please add the support of this panel to drivers/gpu/drm/panel/panel-simple.c.
>>>
>>> Then you can refer its compatible in your board dts.
>>
>> Yes, I'm trying to add the display timings but I couldn't find any
>> info how to find front_portch, back_porch and sync. I remember
>> blanking time = Sync Width + BP + FP so out of which how can we
>> determine each one respectively. Please let me know if you have any
>> idea, I?ve attached the data-sheet.
>
> Does the existing ampire,am800480r3tmqwa1h binding work for your display?

Yes, it is working..but need to understand how these respective
timings were calculated(because I need to add few more) . I tried this
supported ampire but couldn't get the data-sheet. Please point me if
you find any details.

thanks!
-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
