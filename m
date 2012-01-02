From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 2 Jan 2012 23:09:05 +0530
Subject: [RFC][PATCH 2/4] lcd: platform-lcd: Add support for Hydis
 hv070wsa lcd panel
In-Reply-To: <CAH9JG2WjhSsqxPFj+DQrOKXzbHPhm1ddNYE2AeukS7u9c_LA-g@mail.gmail.com>
References: <1325483675-21908-1-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-2-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-3-git-send-email-thomas.abraham@linaro.org>
 <CAH9JG2WjhSsqxPFj+DQrOKXzbHPhm1ddNYE2AeukS7u9c_LA-g@mail.gmail.com>
Message-ID: <CAJuYYwTtXO6+weJ6YANJGUTy90JF3oiCFbDGjgp0GTb7UNUpxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mr. Park,

On 2 January 2012 13:32, Kyungmin Park <kyungmin.park@samsung.com> wrote:
> Hi,
>
> It's not clear to add the panel data at platform_lcd. It's board
> specific and it's used the gpio only.
> So no need to specific it like HYDIS_HV070WSA. just define
> PLATFORM_LCD_GPIO or similar.
>
> How do you think?

Yes, I agree. Looking at other users of platform-lcd driver, it is
better to use config option as you mentioned since many lcd panels use
a single gpio for enable/disable of the panel. I will prepare a new
patch with these changes.

Thanks,
Thomas.

[...]
