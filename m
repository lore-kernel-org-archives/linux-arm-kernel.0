From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 10 Sep 2012 14:57:41 +0530
Subject: [PATCH v2 2/2] ARM: da850/omap-l138: Add EVM specific code for
 VPIF to work
In-Reply-To: <CA+V-a8sGhrTLJnthX+nZESvJfaHFTV=x06eXjQOwwCZwGBxkPQ@mail.gmail.com>
References: <1345471731-31678-1-git-send-email-prabhakar.lad@ti.com>
 <1345471731-31678-3-git-send-email-prabhakar.lad@ti.com>
 <504A2C7D.1090702@ti.com>
 <CA+V-a8sGhrTLJnthX+nZESvJfaHFTV=x06eXjQOwwCZwGBxkPQ@mail.gmail.com>
Message-ID: <504DB28D.3070005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prabhakar,

On 9/7/2012 11:04 PM, Prabhakar Lad wrote:
> On Fri, Sep 7, 2012 at 10:48 PM, Sekhar Nori <nsekhar@ti.com> wrote:

>>> +static struct vpif_subdev_info da850_vpif_capture_sdev_info[] = {
>>> +#if defined(CONFIG_DA850_UI_SD_VIDEO_PORT)
>>
>> You agreed to get rid of these multiple ifdefs but you have not fixed that.
>>
> I have merged the top one, at later stage when we go  ahead and add sensor
> support then we would have require to have define two
> da850_vpif_capture_sdev_info
> so to avoid it I have kept this one.

Lets get to that when we actually add sensor support. It might make
sense then. Right now, there is no reason to have them.

Thanks,
Sekhar
