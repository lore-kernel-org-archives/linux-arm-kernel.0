From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Thu, 21 Feb 2013 17:24:03 +0100
Subject: [RFC/PATCH 4/5] cputime: use do_div() for nsec resolution
 conversion helpers
In-Reply-To: <1361389302-11968-5-git-send-email-khilman@linaro.org>
References: <1361389302-11968-1-git-send-email-khilman@linaro.org>
 <1361389302-11968-5-git-send-email-khilman@linaro.org>
Message-ID: <CAFTL4hxW8WmyTLCtzJoRt0TCqHe1nPUdRkepBy8rzfDBS_wnMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/20 Kevin Hilman <khilman@linaro.org>:
> For the nsec resolution conversions to be useful on non 64-bit
> architectures, do_div() needs to be used for the 64-bit divisions.
>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---

The patch looks good. I'll run and apply it if everything's fine.
