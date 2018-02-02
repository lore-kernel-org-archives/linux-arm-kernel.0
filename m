From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Feb 2018 20:33:35 +0530
Subject: [PATCH v6 28/41] ARM: davinci: remove CONFIG_DAVINCI_RESET_CLOCKS
In-Reply-To: <1516468460-4908-29-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-29-git-send-email-david@lechnology.com>
Message-ID: <a2ae4132-7098-b4f1-5d27-c3eed92ffc3f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:44 PM, David Lechner wrote:
> The common clock framework will take care of disabling unused clocks when
> we switch from the legacy davinci clocks and having this enabled will
> cause compile errors after we switch, so remove it now.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
