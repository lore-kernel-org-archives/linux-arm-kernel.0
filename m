From: will.deacon@arm.com (Will Deacon)
Date: Fri, 31 Jan 2014 00:18:45 +0000
Subject: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
In-Reply-To: <52EAD7EF.3040305@amd.com>
References: <20140117110830.GW3471@alberich> <52E92842.3000001@amd.com>
 <CAL_JsqLhzp5jUJPA91rNkQ07kCDYCDZLxw8LxxFEVP9b12e1Jw@mail.gmail.com>
 <52E93360.1000904@amd.com> <20140129171611.GB13543@alberich>
 <52E939CB.1020705@amd.com>
 <20140129172932.GQ26622@mudshark.cambridge.arm.com>
 <52E940FC.9050602@amd.com>
 <20140129180350.GS26622@mudshark.cambridge.arm.com>
 <52EAD7EF.3040305@amd.com>
Message-ID: <20140131001845.GB5525@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 10:53:35PM +0000, Suravee Suthikulanit wrote:
> On 1/29/2014 12:03 PM, Will Deacon wrote:
> > Interesting... how does that work for PCI? Do you force all devices behind a
> > given RC into the same address space?
> >
> 
> For PCI devices, we are using the bus, device, and function id to make 
> up the 15-bit SID for devices behind a particular PCI root complex.

Very good!

> I also notice that we are currently not supporting the streamID mask in 
> the SMR.  Is this something planed for the future?

Andreas and I are curently working on this -- that's what I was referring to
above. Any feedback from you would be welcomed.

Will
