From: horms@verge.net.au (Simon Horman)
Date: Mon, 7 Nov 2016 09:14:33 +0100
Subject: [PATCH V2] arm64: Add support of R_AARCH64_PREL32 relocation in
 purgatory
In-Reply-To: <3175f823-dd03-07f6-fffe-6ec5487cbf93@infradead.org>
References: <f970f7938109c40833fc45e3d6d72b1dcdf14595.1477627895.git.panand@redhat.com>
 <3175f823-dd03-07f6-fffe-6ec5487cbf93@infradead.org>
Message-ID: <20161107081433.GB13099@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 11:43:48AM -0700, Geoff Levand wrote:
> On 10/27/2016 09:16 PM, Pratyush Anand wrote:
> > gcc version in fedora koji is  6.2.1-2.fc25. kexec-tools compiled with this
> > gcc produced another relocation error:
> > 
> > machine_apply_elf_rel: ERROR Unknown type: 261
> > 
> > This patch fixes the above error.
> 
> Looks good.  Simon, please apply.
> 
> Reviewed-by: Geoff Levand <geoff@infradead.org>

Thanks, applied.
