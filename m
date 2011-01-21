From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 21 Jan 2011 18:33:04 +0000
Subject: [PATCH] video: pxa168fb: remove a redundant pxa168fb_check_var
	call
In-Reply-To: <201101211907.07386.marek.vasut@gmail.com>
References: <1295608686.3976.9.camel@phoenix>
	<201101211907.07386.marek.vasut@gmail.com>
Message-ID: <20110121183304.GA3075@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 07:07:07PM +0100, Marek Vasut wrote:

> Please, don't use the get_maintainers script. This CCs too many people, really. 

*Using* get_maintainers.pl is fine, but it is important to apply taste
to the results since as you say it does generate false positives.
