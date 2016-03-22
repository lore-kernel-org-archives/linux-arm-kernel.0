From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 22 Mar 2016 13:45:41 -0500
Subject: [PATCH 0/6] of: Implement iterator for phandles
In-Reply-To: <1458669509-7178-1-git-send-email-joro@8bytes.org>
References: <1458669509-7178-1-git-send-email-joro@8bytes.org>
Message-ID: <CAL_JsqJ8f0+qQk4QQxyKmwtqnejCDxdjmrZf8480j54YXUTkVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 12:58 PM, Joerg Roedel <joro@8bytes.org> wrote:
> Hi,
>
> here is an implementation of the iterator over phandles
> concept which Rob Herring suggested to me some time ago. My
> approach is a little bit different from what the diff showed
> back then, but it gets rid of the allocation and 'struct
> 'struct of_phandle_args' misuse.
>
> I also converted the arm-smmu driver to make use of the
> iterator. The resulting kernel boots on my AMD Seattle
> system and fixes the warning triggered there. The patches
> now also pass all dt-unittests in my kvm environment.
>
> Please review. Patches are based on v4.5.

Other than my one comment, this looks good to me. For the series:

Acked-by: Rob Herring <robh@kernel.org>
