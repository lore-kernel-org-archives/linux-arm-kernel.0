From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 17 Dec 2013 10:40:21 -0500
Subject: [GIT PULL] ARM: Initial support for Marvell Berlin SoCs
In-Reply-To: <1387202444-7270-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1387202444-7270-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20131217154021.GM2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Mon, Dec 16, 2013 at 03:00:44PM +0100, Sebastian Hesselbarth wrote:
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
>   https://github.com/shesselba/linux-berlin.git topic/initial-for-v3.14

It looks like you didn't use a signed tag here.  I think we ran out of
time at the mini-summit, so here's a quick howto:

$ git checkout topic/initial-for-v3.14
$ git tag -s berlin-3.14  # assumes you have gpg key in local keyring

# edit tag msg, enter pw for key

$ git push --tags <remote> topic/initial-for-v3.14:topic/initial-for-v3.14
$ git request-pull v3.13-rc1 <remote-pub> tags/berlin-3.14

# check if it looks right, if so, pipe it to your email editor


I know some are leary of github, and doing the signed tag gives us a
provable method that what we are pulling is indeed what you created.

I'll send a signed email to Arnd, Olof, and Kevin with the fingerprint
of the key you created at the ARM mini-summit.

thx,

Jason.
