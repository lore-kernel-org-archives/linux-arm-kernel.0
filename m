From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Jul 2015 16:01:39 +0200
Subject: [PATCH v10 4/5] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <1436209848-16530-5-git-send-email-clabbe.montjoie@gmail.com>
References: <1436209848-16530-1-git-send-email-clabbe.montjoie@gmail.com>
 <1436209848-16530-5-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20150707140139.GF28632@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin,

On Mon, Jul 06, 2015 at 09:10:47PM +0200, LABBE Corentin wrote:
> Add support for the Security System included in Allwinner SoC A20.
> The Security System is a hardware cryptographic accelerator that support:
> - MD5 and SHA1 hash algorithms
> - AES block cipher in CBC/ECB mode with 128/196/256bits keys.
> - DES and 3DES block cipher in CBC/ECB mode
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

There's still a number of style issues.

Make sure to run checkpatch with the --strict option, and fix
everything that's reported.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150707/d35fa2a2/attachment.sig>
