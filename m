From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 9 Mar 2015 19:22:40 +0900
Subject: [RFC PATCH] ARM: l2c: Fix prefect settings of parsing
In-Reply-To: <1425645509-30479-1-git-send-email-fabrice.gasnier@st.com>
References: <1425645509-30479-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <CA+Ln22HW3yrz4p9GxVh3G6Feh5uFtzSJ0Csy-g+rh9v_UEsT9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice,

2015-03-06 21:38 GMT+09:00 Fabrice GASNIER <fabrice.gasnier@st.com>:
> Allow prefect settings overriding by of tree, in case
> l2x0_cache_size_of_parse() returns value, prefect tuning
> properties are silently ignored. E.g. arm,double-linefill* and
> arm,prefetch*.
> This happens for example, when "cache-size" or "cache-sets"
> properties haven't been filled in l2c dt node.

Just s/prefect/prefetch/ and s/of tree/device tree/ in patch
description (not sure if this could be fixed while applying or needs
respin). Otherwise:

Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
