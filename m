From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 5 Sep 2009 12:43:03 +0800
Subject: [PATCH 2/5] Treo680: remove unused LCD power GPIO
In-Reply-To: <200909031721.44214.sleep_walker@suse.cz>
References: <1251739561-28972-1-git-send-email-sleep_walker@suse.cz>
	<200909021045.07505.sleep_walker@suse.cz>
	<200909031548.52461.sleep_walker@suse.cz>
	<200909031721.44214.sleep_walker@suse.cz>
Message-ID: <f17812d70909042143s12195d86pc46406c1d09d7210@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 3, 2009 at 11:21 PM, Tom?? 'Sleep_Walker'
?ech<sleep_walker@suse.cz> wrote:
> Hi,
>
> I discussed it with Marex again after his kind review and I created some special function for it to remain machine_init function clean. I hope this one is clean enough to be accepted.
>

OK, applied, with printk(KERN_ERR changed to pr_err()
