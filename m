From: olof@lixom.net (Olof Johansson)
Date: Wed, 10 Apr 2013 10:47:32 -0700
Subject: [PATCH 2/2] ARM: at91: move dts to subdir
In-Reply-To: <5165A3BE.4070001@wwwdotorg.org>
References: <1365585444-11520-1-git-send-email-plagnioj@jcrosoft.com>
 <1365585444-11520-2-git-send-email-plagnioj@jcrosoft.com>
 <5165A3BE.4070001@wwwdotorg.org>
Message-ID: <CAOesGMgu5reWnhYGiDTM+92znRpx7R1vJT1DmVOOyQrpSW5C+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 10:39 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/10/2013 03:17 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>
> A patch description might be nice.
>
> This seems like a nice cleanup to keep the dts directory organized.
> However, it does mean that the *.dtb files get moved again. I know that
> when they moved from boot/ to boot/dts/ in 3.9 (or 3.8?) there were some
> complaints that this made it difficult to write scripts that find the
> built DTB and copy it somewhere. This change would cause the exact same
> problem again.
>
> Perhaps it's time to create an install_dtbs target to solve this problem?

Yes, that's a prerequisite in my opinion.

Also, I said in the previous thread that I want to hold this off for a
couple of releases since it's pure churn. So I'm not interested in
picking this up until 3.12. install_dtbs would be great to see for
3.11 though.


-Olof
