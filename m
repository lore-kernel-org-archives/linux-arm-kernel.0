From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 24 Sep 2014 20:05:46 -0300
Subject: [PATCH 13/18] [media] s5p_mfc_opr_v5: Fix lots of warnings on
 x86_64
In-Reply-To: <5824d4d8b177c3778cea8ef5e345d126e6c46767.1411597610.git.mchehab@osg.samsung.com>
References: <c8634fac0c56cfaa9bdad29d541e95b17c049c0a.1411597610.git.mchehab@osg.samsung.com>
 <5824d4d8b177c3778cea8ef5e345d126e6c46767.1411597610.git.mchehab@osg.samsung.com>
Message-ID: <CAOMZO5BeuqG77tax==sRAWv00YYRcS5x7zKF61uk1Gg15CCPZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 7:27 PM, Mauro Carvalho Chehab
<mchehab@osg.samsung.com> wrote:

> -       mfc_debug(2, "buf_size1: %d, buf_size2: %d\n", buf_size1, buf_size2);
> +       mfc_debug(2, "buf_size1: %zd, buf_size2: %zd\n", buf_size1, buf_size2);


This should be %zu. Same for other %zd ocurrences.
