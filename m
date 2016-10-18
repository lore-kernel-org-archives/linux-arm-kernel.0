From: jack@suse.cz (Jan Kara)
Date: Tue, 18 Oct 2016 14:43:05 +0200
Subject: [PATCH 01/10] mm: remove write/force parameters from
 __get_user_pages_locked()
In-Reply-To: <20161013002020.3062-2-lstoakes@gmail.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-2-lstoakes@gmail.com>
Message-ID: <20161018124305.GA29967@quack2.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 13-10-16 01:20:11, Lorenzo Stoakes wrote:
> This patch removes the write and force parameters from __get_user_pages_locked()
> to make the use of FOLL_FORCE explicit in callers as use of this flag can result
> in surprising behaviour (and hence bugs) within the mm subsystem.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
