From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 15 Aug 2016 23:16:00 +0200
Subject: [PATCH 1/1] sbs-battery: add ability to get battery capacity
In-Reply-To: <1470934752-22719-1-git-send-email-stillcompiling@gmail.com>
References: <1470934752-22719-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <20160815211559.7wr633at523pdxcx@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 11, 2016 at 09:59:12AM -0700, Joshua Clayton wrote:
> Battery capacity level is a standard feature of sbs battery
> That can be used to tell what the remainig battery capacity is, and
> can tell if the battery has not been calibrated/initialized, which makes
> the capacity and charging/discharging percentages invalid.

Patch looks fine to me. I queued it in power-supply's for-next
branch.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160815/87af7f7c/attachment.sig>
