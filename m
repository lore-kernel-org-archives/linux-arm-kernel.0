From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 May 2013 22:44:43 +0400
Subject: [PATCH RFC] clk: Introduce userspace clock driver
In-Reply-To: <51912EE2.6040909@gmail.com>
References: <1368207091-32538-2-git-send-email-soren.brinkmann@xilinx.com>
 <20130510212422.GY3200@sirena.org.uk>
 <7e18bed3-ae6b-4aa0-bf23-b6c61ba8b85b@CO9EHSMHS030.ehs.local>
 <20130512143344.GC3200@sirena.org.uk>
 <9e55c552-ce34-4663-9a57-bf2c626d7d58@TX2EHSMHS008.ehs.local>
 <20130513052135.GD6836@sirena.org.uk>
 <0bf5a185-86f7-4a93-a90f-42caefb06a1d@TX2EHSMHS009.ehs.local>
 <519112F9.2010102@gmail.com> <20130513181625.GB14811@sirena.org.uk>
 <51912EE2.6040909@gmail.com>
Message-ID: <20130513184443.GC14811@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 08:20:18PM +0200, Sebastian Hesselbarth wrote:
> On 05/13/13 20:16, Mark Brown wrote:

> >Yup, that's part of it.  Though I have to say that if all we can do is
> >stuff a bitstream in there there is the question about how anything that
> >does require a real driver gets that driver instantiated...

> Back when I played with Zynq, I remember looking at CONFIG_DYNAMIC_OF
> discussions. ;)

Which then goes back to the whole idea of this being a device - and
possibly that this should be done as part of representing UIO in DT
rather than anything else.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130513/dcfd88d6/attachment-0001.sig>
