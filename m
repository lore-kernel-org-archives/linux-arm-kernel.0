From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 03 Feb 2014 23:08:52 +0100
Subject: [PATCH RFC v4 00/10] ahci: library-ise ahci_platform, add sunxi
 driver and cleanup imx driver
In-Reply-To: <CAL_JsqKnus+9rgLAQ990eD-1F6-2G-SuqYuPkmc+Tw6QP1CT4g@mail.gmail.com>
References: <1390236303-22538-1-git-send-email-hdegoede@redhat.com>
 <CAL_JsqKnus+9rgLAQ990eD-1F6-2G-SuqYuPkmc+Tw6QP1CT4g@mail.gmail.com>
Message-ID: <52F01374.70405@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/03/2014 05:31 PM, Rob Herring wrote:
> On Mon, Jan 20, 2014 at 10:44 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi All,
>>
>> Here is v4 of my patchset for adding ahci-sunxi support. It has grown quite
>> a bit since I've been going for a more generic approach this time and I've
>> also cleaned up the ahci-imx driver to use the same generic approach.
> 
> I don't know if you missed it or just don't intend to refactor all
> AHCI drivers, but the highbank driver could benefit from this as well.

I don't intend to refactor all of them, esp. not the ones for which I don't
have hardware to test.

As they say: patches welcome :)

Regards,

Hans
