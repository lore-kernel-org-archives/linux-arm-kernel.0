From: vbabka@suse.cz (Vlastimil Babka)
Date: Thu, 6 Aug 2015 16:00:33 +0200
Subject: [PATCH V6 2/6] mm: mlock: Add new mlock system call
In-Reply-To: <1438184575-10537-3-git-send-email-emunson@akamai.com>
References: <1438184575-10537-1-git-send-email-emunson@akamai.com>
 <1438184575-10537-3-git-send-email-emunson@akamai.com>
Message-ID: <55C36881.8050301@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2015 05:42 PM, Eric B Munson wrote:
> With the refactored mlock code, introduce a new system call for mlock.
> The new call will allow the user to specify what lock states are being
> added.  mlock2 is trivial at the moment, but a follow on patch will add
> a new mlock state making it useful.
>
> Signed-off-by: Eric B Munson <emunson@akamai.com>
> Cc: Michal Hocko <mhocko@suse.cz>
> Cc: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
