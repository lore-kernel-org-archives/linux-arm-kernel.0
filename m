From: rbyshko@gmail.com (Roman Byshko)
Date: Wed, 29 Oct 2014 14:46:34 +0100
Subject: [PATCH 1/5] phy: sun4i: add support for USB phy0
In-Reply-To: <CAGb2v65gSq+kMnVZMAvXkF6+ARiFE1qRpQ9SFDThfXCg_kERsQ@mail.gmail.com>
References: <cover.1414444953.git.rbyshko@gmail.com>
 <668c1b5541fc0175957573bd5f8d40dd2eaccae1.1414444953.git.rbyshko@gmail.com>
 <20141028214756.GF9255@lukather>
 <CAGb2v65gSq+kMnVZMAvXkF6+ARiFE1qRpQ9SFDThfXCg_kERsQ@mail.gmail.com>
Message-ID: <CAMXmWBkrTwHTXi3Unb3dHLWT2AjC=6u8KLj0ZOHduyMAG8YmLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

sorry for missing Signed-offs, they will be added, of course.

>>> +     /* Regulation 45 ohms */
>>> +     if (phy->index == 0)
>>> +             sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN, 0x01, 1);
>>
>> What is this code supposed to do?
>>
>> Some define for this bit and/or a better comment would be nice.
>
> From Allwinner's sources: "Enable/Disable USB res45 Calibration"
>
> which I think refers to the internal 45 ohm termination resistors
> for the USB data lines. But I'm not an expert on USB hardware.

Same with me. I will however change the comment to make it more informative.

Thanks for your review,
Roman
