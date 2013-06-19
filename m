From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Wed, 19 Jun 2013 15:44:23 +0200
Subject: [PATCH v2] ARM: map_init_section flushes incorrect pmd
In-Reply-To: <1369914361-4237-1-git-send-email-ratbert.chuang@gmail.com>
References: <CANutaR_ZHWdXQrZNBN91K==n3taMKBptmyU0+8DT1RzBStNCyA@mail.gmail.com>
 <1369914361-4237-1-git-send-email-ratbert.chuang@gmail.com>
Message-ID: <CACmBeS3jtkdaREQ7hc2KHzsuR5OULXRMvMiO_fz0ggnYTHJvQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 May 2013 13:46, Po-Yu Chuang <ratbert.chuang@gmail.com> wrote:
> This bug was introduced in commit e651eab0.
> Some v4/v5 platforms failed to boot due to this.

Thanks!

Confirming that this fixes boot on MOXA ART (FA526).

Best regards,
Jonas
