From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 25 Jun 2014 13:42:35 -0700
Subject: [PATCH 0/6] RCU get_user_pages_fast and __get_user_pages_fast
In-Reply-To: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
References: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140625134235.4f32768faa1a4380a62458ff@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Jun 2014 16:40:18 +0100 Steve Capper <steve.capper@linaro.org> wrote:

> This series implements general forms of get_user_pages_fast and
> __get_user_pages_fast and activates them for arm and arm64.

Why not x86?

I think I might have already asked this.  If so, it's your fault for
not updating the changelog ;)
