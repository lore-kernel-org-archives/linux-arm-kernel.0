From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 14 Jan 2015 07:29:52 +1100
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
In-Reply-To: <3097971.rZTsHKr4DO@wuerfel>
References: <20150113111636.7bc5785c@canb.auug.org.au>
 <3097971.rZTsHKr4DO@wuerfel>
Message-ID: <20150114072952.0e0546d1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, 13 Jan 2015 14:18:32 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> There is an extraneous '\' character behind imx6sx-sdb.dtb now, which caused
> build errors for me. We should soon be able to merge the other branches into
> arm-soc to avoid the entire set of merge conflicts, until then please
> change your recorded resolution to avoid the build error.

Oops, sorry about that. Fixed.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/68eb7dff/attachment.sig>
