From: syin@broadcom.com (Sherman Yin)
Date: Mon, 26 Aug 2013 02:46:56 +0000
Subject: [PATCH v2] pinctrl: Pass all configs to driver on pin_config_set()
In-Reply-To: <CACRpkdZeET601+jOsjQxu-VAhi1owgtMX60Fij=uU489eGVFXg@mail.gmail.com>
References: <1376606573-15093-1-git-send-email-syin@broadcom.com>
 <1377134300-25480-1-git-send-email-syin@broadcom.com>
 <CACRpkdZeET601+jOsjQxu-VAhi1owgtMX60Fij=uU489eGVFXg@mail.gmail.com>
Message-ID: <051069C10411E24D9749790C498526FA1BDDCD3B@SJEXCHMB12.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

>Didn't you get review from Stephen Warren?

Yes, just wasn't sure when those tags should be added.  They have been 
added to v3 now.

>Please try to put all the maintainers for the above files on the To: line
>so they get a chance to review/ack the patch.

Ok.  I've added the emails from get_maintainer.pl for each of the files.
v3 has been rebased today and I also applied the API changes to 
pinctrl-palmas.c

Regards,
Sherman
