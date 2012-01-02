From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 2 Jan 2012 09:41:19 +0530
Subject: [PATCH] Input: keyboard - add device tree bindings for simple key
 matrixes
In-Reply-To: <CAOesGMjZoP+FsGWo9cWKvgs8KD9tT6KBHbK5qKX8NTGOY3HUjQ@mail.gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17755DC8D2@HQMAIL01.nvidia.com>
 <CAOesGMiNuW3mexN_8PtunZkaVX4Uph-OgZFr5zLhaB1nih_EEw@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17755DC8DB@HQMAIL01.nvidia.com>
 <CAOesGMjZoP+FsGWo9cWKvgs8KD9tT6KBHbK5qKX8NTGOY3HUjQ@mail.gmail.com>
Message-ID: <CAJuYYwQSgM+zevsSZ71LTYnScLq+q=D7KO3uD5A1O_gOnDAQ=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 29 December 2011 12:36, Olof Johansson <olof@lixom.net> wrote:
[...]

>> Can we deprecate the Samsung format, and only allow it for that Samsung
>> device (and allow both there), and require a single format for any other
>> keyboard?
>
> I'm definitely ok with that. Thomas, Grant, Rob? The code in question
> is queued for 3.3, so it hasn't been out in a real release yet.
>
> Adding Kukjin as well since it's getting merged through his tree.

I am okay with switching to the new keyboard binding. I will modify
the Samsung keyboard device tree support and prepare a patch.

Thanks,
Thomas.
