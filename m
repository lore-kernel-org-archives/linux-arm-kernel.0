From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jun 2013 18:11:44 +0100
Subject: [PATCH V2 2/2] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <51B9DE5C.9030904@wwwdotorg.org>
References: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
 <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
 <20130613074551.GA7769@mudshark.cambridge.arm.com>
 <51B9DE5C.9030904@wwwdotorg.org>
Message-ID: <20130613171144.GH18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 08:59:40AM -0600, Stephen Warren wrote:
> Russell, does this look good to you? I assume I should put this into the
> ARM patch tracker.

I think it's fine.  It would be nice if zhangfei gao would test these
patches and confirm whether they fix it there as well.
