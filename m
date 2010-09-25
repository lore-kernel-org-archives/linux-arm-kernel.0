From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 26 Sep 2010 00:39:43 +0100
Subject: [PATCH 2/5] h1940: fix h1940-bluetooth compilation
In-Reply-To: <1283871605-32068-3-git-send-email-anarsoul@gmail.com>
References: <1283871605-32068-1-git-send-email-anarsoul@gmail.com>
	<1283871605-32068-3-git-send-email-anarsoul@gmail.com>
Message-ID: <4C9E883F.1010608@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/10 16:00, Vasily Khoruzhick wrote:
> h1940-bluetooth.c doesn't compile after s3c gpio API changes,
> this patch fixes issue.

As a note, in future it would be very useful to have the part
of the build output showing the failure when submitting a
bug fix like this.
