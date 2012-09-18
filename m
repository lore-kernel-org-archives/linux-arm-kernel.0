From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 18 Sep 2012 13:59:39 -0700
Subject: [PATCH v2 03/13] hwmon: Versatile Express hwmon driver
In-Reply-To: <20120918174559.227378fc@endymion.delvare>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-4-git-send-email-pawel.moll@arm.com>
 <20120918152430.GA5911@roeck-us.net>
 <20120918174559.227378fc@endymion.delvare>
Message-ID: <20120918205939.GA7006@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 05:45:59PM +0200, Jean Delvare wrote:
> On Tue, 18 Sep 2012 08:24:30 -0700, Guenter Roeck wrote:
> > I don't even understand what you are trying to do, much less why you don't
> > just use the existing infrastructure, and I don't have time to try to figure
> > it out. Maybe Jean has time to review this driver, but not me.
> 
> No, I do not. My backlog is huge already :(
> 
then my conclusion is NACK and that it should be changed to a regular hwmon
driver. I'll be happy to review it once that is done.

Guenter
