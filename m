From: peter@korsgaard.com (Peter Korsgaard)
Date: Tue, 06 Sep 2016 22:38:17 +0200
Subject: [linux-sunxi] [PATCH v2 4/9] drm/sun4i: Add a DRC driver
In-Reply-To: <20160906144620.6322-5-maxime.ripard@free-electrons.com> (Maxime
 Ripard's message of "Tue, 6 Sep 2016 16:46:15 +0200")
References: <20160906144620.6322-1-maxime.ripard@free-electrons.com>
 <20160906144620.6322-5-maxime.ripard@free-electrons.com>
Message-ID: <87y434bw7a.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Maxime" == Maxime Ripard <maxime.ripard@free-electrons.com> writes:

 > The A33 pipeline also has a component called DRC. Even though its exact
 > features and programming model is not known (or documented), it needs to
 > be clocked for the pipeline to carry the video signal all the way.

 > Add a minimal driver for it that just claim the needed resources for the
 > pipeline to operate properly.

 > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
