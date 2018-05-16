From: kim.phillips@arm.com (Kim Phillips)
Date: Wed, 16 May 2018 12:44:51 -0500
Subject: [PATCH 0/3] coresight: Don't use contextID with PID namespaces
In-Reply-To: <1526404417-32507-1-git-send-email-mathieu.poirier@linaro.org>
References: <1526404417-32507-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20180516124451.52f07a2c04cb5211241742a5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 May 2018 11:13:34 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> Since the in-kernel value of a PID differs from what is seen from 
> PID namespaces, using contextID tracing with PID namespaces makes the
> feature confusing to use and potentially subject to leaking out internal
> kernel information.
> 
> This set returns an error if contextID and PID namespaces are used in
> conjunction and gets rid of the vpid-to-pid translation function as it
> is no longer needed.

For the series:

Reviewed-by: Kim Phillips <kim.phillips@arm.com>

Thanks,

Kim
