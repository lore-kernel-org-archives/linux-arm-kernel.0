From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 20 Feb 2012 14:29:47 +0000
Subject: [PATCH v7 4/8] davinci: dm644x: Replace register base value
 with a defined macro
In-Reply-To: <1324475021-32509-5-git-send-email-manjunath.hadli@ti.com>
References: <1324475021-32509-1-git-send-email-manjunath.hadli@ti.com>
 <1324475021-32509-5-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317C79D5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

On Wed, Dec 21, 2011 at 19:13:37, Hadli, Manjunath wrote:
> Replace hard coded value of vpss register base to a define macro
> DM644X_VPSS_BASE for proper readability
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> Acked-by: Sekhar Nori <nsekhar@ti.com>

The subject line does not follow the format we have in place now.
Also in the subject, the term "defined macro" is odd. You have
fixed some indentation issues with earlier code in this patch.
That should find a mention too. I made these (and some other minor) 
improvements to the patch text while committing.

Please have a look and take care next time onward. Here is the
new text:

    ARM: davinci: dm644x: improve readability using macro

    Replace the VPSS base address "magic number" with the
    define "DM644X_VPSS_BASE" to improve readability.

    While at it, fix the indentation done using spaces in
    this part of code.

    Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
