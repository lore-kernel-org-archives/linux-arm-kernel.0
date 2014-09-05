From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 05 Sep 2014 13:27:06 -0700
Subject: [PATCH] bus: arm-ccn: Move event cleanup routine
In-Reply-To: <1409671571-4606-1-git-send-email-pawel.moll@arm.com> (Pawel
 Moll's message of "Tue, 2 Sep 2014 16:26:11 +0100")
References: <1409671571-4606-1-git-send-email-pawel.moll@arm.com>
Message-ID: <7hegvpyfs5.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pawel Moll <pawel.moll@arm.com> writes:

> From: Pawel Moll <mail@pawelmoll.com>
>
> The function cleaning up an initialized event
> was called from the "event_del" handler, instead
> of being used as the "destroy" callback. In case of
> events group allocation this caused NULL pointer
> dereference (as events are added and deleted
> multiple times then). Fixed now.
>
> Signed-off-by: Pawel Moll <mail@pawelmoll.com>

Applied to fixes,

Thanks,

Kevin
