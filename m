From: chris@chris-wilson.co.uk (Chris Wilson)
Date: Wed, 24 Jan 2018 09:14:28 +0000
Subject: [PATCH 1/5] drm: rename {drm_clflush_sg, drm_clflush_pages}
In-Reply-To: <20180124025534.2964-1-gurchetansingh@chromium.org>
References: <20180124025534.2964-1-gurchetansingh@chromium.org>
Message-ID: <151678526849.13096.14873692697066951124@mail.alporthouse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gurchetan Singh (2018-01-24 02:55:30)
> Since clfush is an x86-only instruction, these function names won't
> make much sense if we start adding cases for other architectures.

Whatever your dislike for the name, it has one clear advantage over the
new one: it tells you what it is flushing.
-Chris
