From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Sep 2012 14:09:15 -0700
Subject: [GIT PULL] dove late fixes for v3.7
In-Reply-To: <20120925020716.GY5469@titan.lakedaemon.net>
References: <20120925020716.GY5469@titan.lakedaemon.net>
Message-ID: <20120929210915.GE12999@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 24, 2012 at 10:07:16PM -0400, Jason Cooper wrote:
> Depends:
>  - Based against arm-soc/for-next

Unfortunately this won't work. The arm-soc for-next branch is not a stable
branch, it's the aggregate where we merge in the contents of different next/*
branches for staging, but the branch itself doesn't get sent upstream.

Can you rebase this branch against something that makes more sense? Ideally the
branch that introduced the breakage, since that will minimize the upstream
exposure to the bugs.


-Olof
