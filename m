From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 23 Feb 2010 17:04:09 -0500 (EST)
Subject: =?ISO-8859-15?Q?Re=3A_=5BPATCH=5D=A0MPP_routines_and_definitions_for_MV78XX0_arch?=
In-Reply-To: <4B83DA46.4030309@kolios.dk>
References: <4B83DA46.4030309@kolios.dk>
Message-ID: <alpine.LFD.2.00.1002231655250.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Feb 2010, Sebastien Requiem wrote:

> Hi everyone,
> 
> 
> I have recently created the routines to configure the MPP
> lines on specific plateform for the architecture MV78XX0.
> 
> 
> Patch description :
> ============
> This patch is composed of two new files :
> - mpp.c which is mainly inspired by the same
> file as in mach-kirkwood
> - mpp.h that is written from the documentation provided
> by Marvell
> 
> http://www.marvell.com/products/processors/embedded/discovery_innovation/HW_MV78100_OpenSource.pdf
> 
> moreover, due to some implementation problem, I have
> defined some MPPX_UNUSED that offer the posibility
> to developers to SET MPP to some unused value
> (such as Buffalo WXL)
> 
> Note: This patch doesn't support MV78200 yet (only 78100 MPP lines have been
> written)
> =============
> 
> 
> I would very much appreciate if you could review the patch
> and give feedback/comments.

You should put the Signed-off-by tag along with your patch description, 
not after the patch.

The coding style requires hard tabs for code indentation, and those 
must be 8 space width.  More details in Documentation/CodingStyle.

You forgot to include the change to Makefile for the new file.

I've fixed those up and committed the patch to the orion git tree.


Nicolas
