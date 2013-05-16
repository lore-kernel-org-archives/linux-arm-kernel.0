From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 May 2013 11:04:25 -0700
Subject: [PATCH] ARM: OMAP: fix __init section mismatch for
 _enable_preprogram
In-Reply-To: <CAGGh5h1_-zbe=gw+YtMeddGxGkVzos=siavOv9nbSOVZqk1nVw@mail.gmail.com>
References: <CAGGh5h1_-zbe=gw+YtMeddGxGkVzos=siavOv9nbSOVZqk1nVw@mail.gmail.com>
Message-ID: <20130516180425.GE5600@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* jean-philippe francois <jp.francois@cynove.com> [130513 02:34]:
> Hi,
> 
> _enable_preprogram is marked as __init, but is called from _enable
> which is not. Without this patch, the board oopses after init. Tested
> on custom hardware and on beagle board xM.
> 
> Signed-off-by: Jean-Philippe Fran?ois <jp.francois@cynove.com>

Thanks applying into omap-for-v3.10/fixes.

Regards,

Tony
