From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 17 Jul 2014 17:09:59 +0200
Subject: [PATCH v2 1/5] i2c: Don't start transfers when suspended
In-Reply-To: <CABYn4swJ5NHyUd5+zCK6jhHex4v9DCMe5Qo-BZqxjPf90JfusQ@mail.gmail.com>
References: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
 <CABYn4swJ5NHyUd5+zCK6jhHex4v9DCMe5Qo-BZqxjPf90JfusQ@mail.gmail.com>
Message-ID: <20140717150958.GA2901@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 04:58:17PM +0200, Bastian Hecht wrote:
> I want to add the remark that I can't help further on the patch series
> in the next month about. So this is free to be taken/ignored/modified
> without any approval by my side.

Good to know. I'd like to get some Tested-by tags before applying to
make sure we have no regressions. So, with you being away, let's just
schedule this for 3.18 and we have all the time we need. Thanks for
finishing this code before you left. Have a great month!

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/d4afdd25/attachment.sig>
