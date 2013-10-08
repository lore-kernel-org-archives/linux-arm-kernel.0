From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Oct 2013 12:11:45 -0400
Subject: [PATCH 2/2] ARM: Dove: Add the audio device to the Cubox DT
In-Reply-To: <20131003181716.6d03d576@armhf>
References: <20130828113521.35c53365@armhf> <521DCD80.9010105@gmail.com>
 <20130831125128.0e3a23c7@armhf>
 <140d8d8a23f.2784.107cef0f820c2f5d7b7f41463071c310@gmail.com>
 <20130926101147.217015e1@armhf> <5243F0CE.9000301@gmail.com>
 <20130926132859.04ad4407@armhf> <5246E747.6020103@gmail.com>
 <20131003181716.6d03d576@armhf>
Message-ID: <20131008161145.GJ5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Francois,

On Thu, Oct 03, 2013 at 06:17:16PM +0200, Jean-Francois Moine wrote:
> It seems that my patch about adding s/pdif to the kirkwood audio driver
> has not been accepted yet...

Looking over that conversation does not give the impression that
concerns were resolved.  I'm a little short on time atm, all I can add
definitively is that I agree with Thomas wrt the compatible strings.
They should be named after the first compatible IP block (in this case,
kirkwood).

Please submit a fix for v3.12-rc cleaning up what Mark Brown accepted so
we don't have to maintain it indefinitely, and we'll see if we can work
out the rest in fairly short order.  Posting a new version of series
would help kick off that conversation... ;-)

thx,

Jason.
