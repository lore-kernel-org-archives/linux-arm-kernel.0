From: mathias.nyman@intel.com (Mathias Nyman)
Date: Wed, 07 Oct 2015 16:20:05 +0300
Subject: [PATCH v8 0/3] usb: xhci-platform: Configure 64-bit DMA mask
 if the platform is capable
In-Reply-To: <20151004091059.GA32394@kroah.com>
References: <CADaLNDno0cLXH3_4NG75fk6T31Pe5BCrbcUpA0cGriCwSh6OyQ@mail.gmail.com>
 <cover.1442513540.git.dhdang@apm.com>
 <CADaLNDkQEZ-TA3PS-RdEWTGi3rxgqxHTDgvNO8De+VXeMKeJnw@mail.gmail.com>
 <20151004091059.GA32394@kroah.com>
Message-ID: <56151C05.4040909@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.10.2015 12:10, Greg KH wrote:
> On Wed, Sep 30, 2015 at 02:24:30PM -0700, Duc Dang wrote:
>> On Thu, Sep 17, 2015 at 11:19 AM, Duc Dang <dhdang@apm.com> wrote:
>>> The xhci platform driver does not work with system that only supports
>>> 64-bit DMA as it requests 32-bit DMA mask during driver initialization.
>>> This patch set addresses this issue and also adds XHCI-compliant USB
>>> Controller ACPI identification into xhci-platform driver.
>>
>> Hi Greg, Mathias,
>>
>> Arnd already ack-ed the first patch, please let me know if you have
>> more comment on this set?
>
> I'm waiting for Mathias to forward this on to me as he's the xhci
> maintainer.
>

I got them waiting in my queue, just need to sort out some other unrelated patches
before passing everything forward.

-Mathias
