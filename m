From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Oct 2012 20:51:23 +0300
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <5086D91A.5080109@firmworks.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121022155028.GA13791@core.coreip.homeip.net>
 <CACRpkdaQ1WfRWrx=RXMVkeFtwdERJsOpVa3DaXBTU2KZdgqhRQ@mail.gmail.com>
 <508664CA.7000601@ti.com>
 <CACRpkdbhCS-Vb0DtbTZQ_Zw_8SOh3Bqutme3Y2-QrxNqvMiNNw@mail.gmail.com>
 <20121023100333.GA24418@arwen.pp.htv.fi>
 <5086CD91.9070101@firmworks.com>
 <20121023172035.GB32167@arwen.pp.htv.fi>
 <5086D91A.5080109@firmworks.com>
Message-ID: <20121023175123.GB32517@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(please don't top-post)

On Tue, Oct 23, 2012 at 07:51:22AM -1000, Mitch Bradley wrote:
> Perhaps I misunderstood what you were suggesting.  I thought that, when
> you said "explicitly manage all their resources", you meant that the
> driver should know the platform-specific details about clocks and power
> domains.  That is one possible interpretation of the word "explicit".

we had two suggestions in the thread:

1) handle it in driver source code (explict)
2) handle at bus notifiers level (hidden)

archives would've helped you clear up that confusion ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/87fc4f04/attachment.sig>
