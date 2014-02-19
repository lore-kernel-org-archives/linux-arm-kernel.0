From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Wed, 19 Feb 2014 08:04:49 -0800
Subject: [PATCH RFC v4 3/3] Documentation: arm: define DT idle states
 bindings
In-Reply-To: <1392724051-11950-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1392724051-11950-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392724051-11950-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140219160449.11460.93660@capellas-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lorenzo Pieralisi (2014-02-18 03:47:31)
> +       - index
> +               Usage: Required
> +               Value type: <u32>
> +               Definition: It represents the idle state index.
> +                           An increasing index value implies less power
> +                           consumption. Index must be given a sequential
> +                           value = {0, 1, ....}, starting from 0.
One minor comment.  In the example, it can be tricky to see how this is sequential
since the states interleave.  Not sure if it merits rewording here?

These look good to me!

Thanks!

Sebastian
