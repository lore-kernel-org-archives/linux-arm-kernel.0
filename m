From: lenb@kernel.org (Len Brown)
Date: Thu, 5 Dec 2013 16:46:40 -0500
Subject: [PATCH 0/5] PM: Enable option of re-use runtime PM callbacks at
 system suspend
In-Reply-To: <CAPDyKFpf58CRKUhFPKHyg4S9oaUR=XHJQs=hK7p63Hkv8gnbbw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1311291014020.27250-100000@netrider.rowland.org>
 <4994754.y6gINBtP7i@vostro.rjw.lan>
 <CAPDyKFpf58CRKUhFPKHyg4S9oaUR=XHJQs=hK7p63Hkv8gnbbw@mail.gmail.com>
Message-ID: <CAJvTdKnqD3ccPUzh7kNMNqrEYFfD93Vh9hgFuKyHz+pjGNHdtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This thread raises the question...

Do we still need to have PM_RUNTIME apart from PM_SLEEP?

What is the benefit of being able to build-in one one without the other?
If that benefit is not significant, perhaps the time has come to
replace them both with CONFIG_PM...

cheers,
-Len Brown, Intel Open Source Technology Center
