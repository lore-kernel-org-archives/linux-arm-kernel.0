From: evgreen@chromium.org (Evan Green)
Date: Fri, 11 May 2018 14:29:19 -0700
Subject: [PATCH v4 7/7] interconnect: Allow endpoints translation via DT
In-Reply-To: <20180309210958.16672-8-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-8-georgi.djakov@linaro.org>
Message-ID: <CAE=gft4-gBsdmwVOModwq1iNw91phc0Zp9Qvy8jqPiBYo4Zp5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 9, 2018 at 1:10 PM Georgi Djakov <georgi.djakov@linaro.org>
wrote:

> Currently we support only platform data for specifying the interconnect
> endpoints. As now the endpoints are hard-coded into the consumer driver
> this may leed to complications when a single driver is used by multiple

Nit: s/leed/lead/

-Evan
