From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 02 Jun 2014 12:51:19 -0700
Subject: [PATCH v7 0/2] context tracker support for arm64
In-Reply-To: <1401478455-26391-1-git-send-email-larry.bassel@linaro.org>
 (Larry Bassel's message of "Fri, 30 May 2014 12:34:13 -0700")
References: <1401478455-26391-1-git-send-email-larry.bassel@linaro.org>
Message-ID: <7hvbsjw0nc.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Larry Bassel <larry.bassel@linaro.org> writes:

> Implement and enable context tracking for arm64 (which is
> a prerequisite for FULL_NOHZ support). This patchset
> builds upon earlier work by Kevin Hilman and is based on
> Will Deacon's tree.
>
> Changes v6 to v7:
>
> * Rename parameter of ct_user_exit from restore to syscall

Also for v7:

Reviewed-by: Kevin Hilman <khilman@linaro.org>
Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin
