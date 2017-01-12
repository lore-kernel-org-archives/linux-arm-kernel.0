From: drjones@redhat.com (Andrew Jones)
Date: Thu, 12 Jan 2017 18:04:21 +0100
Subject: [kvm-unit-tests PATCH 3/6] docs: move README to README.md and
 symlink
In-Reply-To: <20170111162841.15569-4-alex.bennee@linaro.org>
References: <20170111162841.15569-1-alex.bennee@linaro.org>
 <20170111162841.15569-4-alex.bennee@linaro.org>
Message-ID: <20170112170421.kr4jlyjzavifu2f6@hawk.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 04:28:38PM +0000, Alex Benn?e wrote:
> This allows a slightly nicer formatting of the text when displayed on
> some repository hosts. We keep a symlink from README for the
> old-school purists.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> ---
>  README    | 69 +----------------------------------------------------
>  README.md | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 68 deletions(-)
>  mode change 100644 => 120000 README
>  create mode 100644 README.md

Please use 'format-patch -M' to create patches when renaming files.
I'm not sure I care about having a .md version or not, but only
one README* file in the root dir would be my preference, i.e. if we
want a .md version, then let's just have that, i.e no symlink.

Thanks,
drew
