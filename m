From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 10 Mar 2014 08:19:03 -0300
Subject: [PATCH 1/9] usb: chipidea: usbmisc: Add USB Host support for
 i.MX25/i.MX35 CPUs
In-Reply-To: <20140310065520.469cac2e@e6520eb>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
 <CAOMZO5DPK41DqNT7b_eV2owqPvAsqHZ7zgkqDVSmPUx2Bv2TVA@mail.gmail.com>
 <20140310065520.469cac2e@e6520eb>
Message-ID: <CAOMZO5Do3GU9aYzTffOoD7sYSYwtQU4wVSEmW78aF+c8179QuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Mon, Mar 10, 2014 at 2:55 AM, Eric B?nard <eric@eukrea.com> wrote:
> Hi Fabio,

>> (Not sure why it says full-speed device. When I connect the same
>> device to a PC it says high-speed)
>>
> because i.MX25 and i.MX35 only have a full speed phy on the host port.

This makes sense, thanks.
